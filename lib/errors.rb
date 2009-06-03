module Errors
  Messages = ActiveRecord::Errors.default_error_messages

  # ActiveRecord::Errors.default_error_messages[:inclusion] = " is niet opgenomen in de lijst" 
  # ActiveRecord::Errors.default_error_messages[:exclusion] = " is niet toegestaan in de lijst" 
  # ActiveRecord::Errors.default_error_messages[:invalid] = " is ongeldig" 
  # ActiveRecord::Errors.default_error_messages[:confirmation] = " is niet gelijk aan de bevestiging" 
  # ActiveRecord::Errors.default_error_messages[:accepted] = " moet geaccepteerd worden" 
  # ActiveRecord::Errors.default_error_messages[:empty] = " mag niet leeg zijn" 
  # ActiveRecord::Errors.default_error_messages[:blank] = " mag niet leeg zijn" 
  # ActiveRecord::Errors.default_error_messages[:too_long] = " is te lang (max is %d tekens)" 
  # ActiveRecord::Errors.default_error_messages[:too_short] = " is te kort(min is %d tekens)" 
  # ActiveRecord::Errors.default_error_messages[:wrong_length] = " heeft de verkeerde lengte (moet %d tekens zijn)" 
  # ActiveRecord::Errors.default_error_messages[:taken] = " is al in gebruik" 
  # ActiveRecord::Errors.default_error_messages[:not_a_number] = " is geen getal"
end
