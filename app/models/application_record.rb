class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def log_in!

  end

  def log_out!

  end
end
