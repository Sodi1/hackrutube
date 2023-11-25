module Api
  class VideosController < ApiController
    def search
      options = {
        fields: SearchField.active.string.map{"#{_1.value}^#{_1.factor}"},
        boost_by: SearchField.active.numeric.map{ {_1.value => {factor: _1.factor} }}.reduce(&:merge),
        boost_where: Personalization.find_by(name: params[:user_class])&.value&.deep_symbolize_keys,
        load: false,
        limit: limit,
        offset: offset,
        operator: params[:q].match?(/ \| /) ? :or : :and,
        suggest: [:video_title]
      }.merge(( search_params)).filter{|k,v| !v.nil? }
      published_at = SearchField.active.datetime.first
      options.merge!({boost_by_recency: {published_at.value => {scale: published_at.boost_by_recency_scale  , decay: published_at.boost_by_recency_decay}},}) if published_at
      puts options
      collection = Video.search(params[:q], **options)
      if collection.results.size < 5
        options.merge!(operator: :or)
        collection = Video.search(params[:q], **options)
      end
      if params[:autocomplete]
        render json: {
          autocomplete: collection.map(&:video_title)
        }
      else
        render json: {
          suggestions: collection.suggestions,
          search: collection
        }
      end

    end

    def search_params
      permited = params[:search_params]&.permit!
      permited&.to_h&.deep_symbolize_keys || {}
    end

    def limit
      params[:limit] || 20
    end
    def offset
      params[:offset] || 0
    end
  end
end