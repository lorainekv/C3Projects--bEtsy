class ShipmentValidator < ActiveModel::Validator
  STATE_ABBRS = %w(AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY)

  def validate(shipment)
    unless STATE_ABBRS.include?(shipment.state)
      shipment.errors.add(:invalid_state, "Please enter a valid state abbreviation.")
    end
  end
end
