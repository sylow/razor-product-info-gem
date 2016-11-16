require 'spec_helper'

describe RazorProductInfo do
  it 'has a version number' do
    expect(RazorProductInfo::VERSION).not_to be nil
  end
end
