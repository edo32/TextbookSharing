class Textbook < ActiveRecord::Base
  #include Elasticsearch::Model
  #include Elasticsearch::Model::Callbacks

  belongs_to :user

  # Data validation
  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true, length: { minimum: 10 }, format: {with: /\A(\d+(-)*)+\Z/}
  validates :price, presence: true


  # settings index: { number_of_shards: 1 } do
  #   mapping dynamic: 'false' do
  #     indexes :id, indexes: :not_analyzed
  #     indexes :title, analyzer: 'english'
  #     indexes :author
  #     indexes :isbn
  #   end
  #
  # end
  # Mapping
  mapping do
    indexes :id, indexes: :not_analyzed
    indexes :title
    indexes :author
    indexes :isbn
  end

  def as_indexed_json(options = {})
    self.as_json({only: [:id, :title, :author, :isbn],
      include: {
        user: { only: [:name]}
      }
    })
  end
end
