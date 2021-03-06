schema "0001 initial" do

  entity "FavoriteLocation" do
    string :name, optional: false
  end

  entity "Dam" do
    string :name, optional: false
    float :percentage,   default: 0
    float :delta,   default: 0
    datetime :last_update_at
    boolean :favorite, default: false
    integer32  :order
  end

  # Examples:
  #
  # entity "Person" do
  #   string :name, optional: false
  #
  #   has_many :posts
  # end
  #
  # entity "Post" do
  #   string :title, optional: false
  #   string :body
  #
  #   datetime :created_at
  #   datetime :updated_at
  #
  #   has_many :replies, inverse: "Post.parent"
  #   belongs_to :parent, inverse: "Post.replies"
  #
  #   belongs_to :person
  # end

end
