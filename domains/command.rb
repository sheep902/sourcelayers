module Command
  extend ActiveSupport::Concern

  included do
    include PacerRecord
    links :runner
  end
end