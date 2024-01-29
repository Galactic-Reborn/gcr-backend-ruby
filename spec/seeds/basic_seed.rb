require 'rails_helper'

RSpec.shared_examples "basic_seed" do


  before(:each) do
    load_test_data
  end

  def load_test_data
  end

end