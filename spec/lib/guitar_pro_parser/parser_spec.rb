require 'spec_helper'

FILE_PATH = 'spec/tabs/tab.gp5'

describe GuitarProParser::Parser do
  subject { GuitarProParser::Parser.new FILE_PATH}
  
  describe '#read_byte' do
    let!(:result) { subject.read_byte }

    its(:offset) { should == 1}
    specify { result.should == 24 }
  end

  describe '#read_integer' do
    before (:each) do
      subject.offset = 31
    end

    let!(:result) { subject.read_integer }
    
    its(:offset) { should == 35}
    specify { result.should == 11 }
  end

  shared_examples 'read_string and read_chunk' do
    its(:offset) { should == 46 }
    specify { result.should == 'Song Title' }
  end

  describe '#read_string' do
    before (:each) do
      subject.offset = 36
    end

    let!(:result) { subject.read_string 10 }
  
    it_behaves_like 'read_string and read_chunk'
  end

  describe '#read_chunk' do
    before (:each) do
      subject.offset = 31
    end

    let!(:result) { subject.read_chunk }
  
    it_behaves_like 'read_string and read_chunk'
  end

  describe '#increment_offset' do
    it 'changes offset' do
      subject.increment_offset 5
      subject.offset.should == 5
    end
  end
end