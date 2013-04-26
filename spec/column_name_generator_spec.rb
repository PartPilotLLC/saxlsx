require 'spec_helper'

describe ColumnNameGenerator do

  it 'First' do
    ColumnNameGenerator.first.should eq 'A'
  end

  it 'Next value' do
    ColumnNameGenerator.tap do |g|
      g.next_to(nil).should eq 'A'
      g.next_to('F').should eq 'G'
      g.next_to('DM').should eq 'DN'
      g.next_to('RZ').should eq 'SA'
      g.next_to('ZZ').should eq 'AAA'
      g.next_to('EDT').should eq 'EDU'
    end
  end

end