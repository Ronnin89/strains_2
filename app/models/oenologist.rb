class Oenologist < ApplicationRecord
    has_many :wine_oenologists
    has_many :oenologists, through: :wine_oenologists
end
