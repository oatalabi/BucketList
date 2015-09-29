class BucketlistSerializer < ActiveModel::Serializer
  attributes :id, :name, :items, :date_created, :date_modified, :created_by

  has_many :items

  def date_created
    "#{object.created_at}"
  end

  def date_modified
    "#{object.updated_at}"
  end

  def created_by
    "#{object.user_id}"
  end
 
end
