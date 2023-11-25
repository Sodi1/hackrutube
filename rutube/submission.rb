require 'typhoeus'
require 'json'
require 'csv'

def read_file(file_path)
  File.readlines(file_path).map(&:strip).uniq.map{ _1.gsub(/"$/, "").gsub(/^"/, '') }
end

def create_request(query, index)
  Typhoeus::Request.new(
    "https://rutube-api.kovalev.team//api/videos/search",
    method: :post,
    headers: { 'Content-Type' => 'application/json' },
    body: {
      q: query,
      search_params: {
        misspellings: { below: 5, edit_distance: 1 }
      }
    }.to_json
  ).tap do |request|
    request.options[:headers]["X-Query-Index"] = index
  end
end

def write_results_to_csv(results, file_path, include_title: false)
  CSV.open(file_path, "wb") do |csv|
    headers = include_title ? ["query", "query_text", "video_id", "video_title"] : ["query", "video_id"]
    csv << headers
    results.each do |result|
      query_index = "query_#{result[:index]}"
      5.times do |i|
        video = result[:videos][i] || {}
        row = include_title ? [query_index, result[:query], video[:video_id] || '', video[:video_title] || ''] : [result[:query], video[:video_id] || 'video_26648098']
        csv << row
      end
    end
  end
end

def process_queries(input_file_path, output_file_path, output_file_path_with_titles)
  queries = read_file(input_file_path)
  hydra = Typhoeus::Hydra.new
  hydra.max_concurrency = 50
  suggestion_hydra = Typhoeus::Hydra.new
  results = Array.new(queries.size) { { videos: [] } }

  queries.each_with_index do |query, index|
    request = create_request(query, index)
    request.on_complete do |response|
      idx = response.request.options[:headers]["X-Query-Index"].to_i
      result = JSON.parse(response.body)
      if result["suggestions"].nil?
        p query
        p response.code
        next
      end
      if result["suggestions"].empty?
        videos = result["search"]["query"].map { |video| { query: query, video_id: video["video_id"], video_title: video["video_title"] } }.take(5)
        results[index] = videos
        videos = result["search"]["query"].map { |video| { video_id: video["video_id"], video_title: video["video_title"] } }
        results[idx] = { index: idx, query: query, videos: videos }
      else
        # Take the first suggestion and process it
        suggested_query = result["suggestions"].first
        additional_request = create_request(suggested_query, idx)
        suggestion_hydra.queue(additional_request)
        additional_request.on_complete do |additional_response|
          idx = additional_response.request.options[:headers]["X-Query-Index"].to_i
          result = JSON.parse(additional_response.body)
          videos = result["search"]["query"].map { |video| { query: query, video_id: video["video_id"], video_title: video["video_title"] } }.take(5)
          results[idx] = { index: idx, query: query, videos: videos }
        end
      end
    end
    hydra.queue(request)
  end

  hydra.run
  suggestion_hydra.run
  write_results_to_csv(results.compact, output_file_path)
  write_results_to_csv(results.compact, output_file_path_with_titles, include_title: true)
end

# Example usage
input_file_path = 'test_dataset_submission_queries.txt'
output_file_path = 'output_file.csv'
output_file_path_with_titles = 'output_file_with_titles.csv'
process_queries(input_file_path, output_file_path, output_file_path_with_titles)
