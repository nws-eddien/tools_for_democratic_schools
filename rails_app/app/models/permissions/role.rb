class Role < ApplicationRecord
    has_and_belongs_to_many :membershiplevels
    has_and_belongs_to_many :users
    belongs_to :app
    has_many :role_permissions
    has_many :permissions, through: :role_permissions

    def previous_role
        app.roles.ordered.where("name < ?", name).last
    end

    scope :ordered, -> {order(name: :asc)}

end
