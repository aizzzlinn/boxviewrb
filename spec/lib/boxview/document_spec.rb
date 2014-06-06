require 'spec_helper'

describe BoxView::Document, '#document_id' do

  it 'should raise error when document id is nil' do
    expect{BoxView.document_id}.to raise_error(BoxView::Errors::DocumentIdNotFound)
  end

end

describe BoxView::Document, '#dimensions' do

  it 'should raise error when dimensions are nil' do
    expect{BoxView::Document.dimensions}.to raise_error(BoxView::Errors::DimensionsNotFound)
  end

  it 'should raise error when height is nil, but width is defined' do
    BoxView::Document.width = 100
    BoxView::Document.height = nil
    expect{BoxView::Document.dimensions}.to raise_error(BoxView::Errors::DimensionsNotFound)
  end

  it 'should raise error when width is nil, but height is defined' do
    BoxView::Document.width = nil
    BoxView::Document.height = 100
    expect{BoxView::Document.dimensions}.to raise_error(BoxView::Errors::DimensionsNotFound)
  end

end

describe BoxView::Document, '#thumbnail_params' do

  it 'should raise when dimensions are nil' do
    expect{BoxView::Document.thumbnail_params}.to raise_error(BoxView::Errors::DimensionsNotFound)
  end

  it 'should raise when height is nil, but width is defined' do
    BoxView::Document.width = 100
    BoxView::Document.height = nil
    expect{BoxView::Document.thumbnail_params}.to raise_error(BoxView::Errors::DimensionsNotFound)
  end

  it 'should raise when width is nil, but height is defined' do
    BoxView::Document.width = nil
    BoxView::Document.height = 100
    expect{BoxView::Document.thumbnail_params}.to raise_error(BoxView::Errors::DimensionsNotFound)
  end
end
describe BoxView::Document, '#create' do
  xit 'should raise when receiving a 500' do
  end

  it 'should raise when receiving a bad api key' do
    BoxView.api_key = 'somesortofbadapikey'
    BoxView::Document.url = 'http://imgur.com/cats.jpeg'
    expect{BoxView::Document.create}.to raise_error(BoxView::Errors::DocumentIdNotGenerated)
  end

  it 'should return the response when sent a good request (200..202)' do
    BoxView.api_key = API_KEY
    BoxView::Document.url = 'http://i.imgur.com/4RZkFbE.png'
    response = BoxView::Document.create
    expect(200..202).to cover(response.code)
  end
end