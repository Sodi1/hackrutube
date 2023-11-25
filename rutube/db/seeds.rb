require 'csv'
attributes = []
CSV.open("./db/dummy_video.csv").each do |line|
  attributes.push(  {
                      video_title: line[1],
  })
end
Video.insert_all(attributes)

Video.select(:category).distinct.each{ Category.find_or_create_by(title: _1.v_category_y)}
Video.new.attributes.keys.each{ SearchField.create(name: _1, value: _1, factor: 1, kind: :string) }