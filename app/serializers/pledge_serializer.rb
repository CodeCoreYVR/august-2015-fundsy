class PledgeSerializer < ActiveModel::Serializer
  attributes :id, :amount, :stripe_txn_id, :aasm_state
  has_one :user
  has_one :campaign
end
