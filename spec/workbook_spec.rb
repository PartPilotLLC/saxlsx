require 'spec_helper'

describe Workbook do

  let(:filename) { "#{File.dirname(__FILE__)}/data/Spec.xlsx" }

  it 'Sheets count' do
    Workbook.open filename do |w|
      w.should have(5).sheets
    end
  end

  it 'Sheet names' do
    Workbook.open filename do |w|
      w.sheet_names.should eq %w(test_otros test_spec test_param Lenguajes ont_demo)
    end
  end

  it 'Find sheet by index' do
    Workbook.open filename do |w|
      w.sheets[0].name.should eq 'test_otros'
      w.sheets[1].name.should eq 'test_spec'
      w.sheets[2].name.should eq 'test_param'
      w.sheets[3].name.should eq 'Lenguajes'
      w.sheets[4].name.should eq 'ont_demo'
    end
  end

  it 'Find sheet by name' do
    Workbook.open filename do |w|
      w.sheets('test_otros').name.should eq 'test_otros'
      w.sheets('test_spec').name.should eq 'test_spec'
      w.sheets('test_param').name.should eq 'test_param'
      w.sheets('Lenguajes').name.should eq 'Lenguajes'
      w.sheets('ont_demo').name.should eq 'ont_demo'
    end
  end

  it 'Shared strings' do
    Workbook.open filename do |w|
      w.should have(56).shared_strings
      w.shared_strings[0].should eq 'LevenshteinDistance'
      w.shared_strings[55].should eq 'TST_ModMan_Insulto_SU_Normal'
    end
  end

  it 'Export to CSV' do
    Workbook.open filename do |w|
      w.sheets.each { |s| s.should_receive(:to_csv).with(Dir.pwd) }
      w.to_csv Dir.pwd
    end
  end

  xit 'Large xlsx' do
    #require 'ruby-prof'

    #result = RubyProf.profile do
    Workbook.open 'spec/data/SpecLarge.xlsx' do |w|
      w.sheets.parallel(in_processes: 4).each do |s|
        s.to_csv "#{File.dirname(__FILE__)}/../tmp"
      end
    end
    #end

    #printer = RubyProf::GraphHtmlPrinter.new(result)
    #File.open('profile.html', 'w') { |f| printer.print(f, {}) }
  end

end