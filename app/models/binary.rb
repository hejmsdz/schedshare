class Binary < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  def self.latest_per_user
    arel = arel_table
    ids_subquery = arel.project(arel[:id]).distinct_on(arel[:user_id]).order(arel[:user_id], arel[:id].desc)

    where("id IN (#{ids_subquery.to_sql})")
  end
end
