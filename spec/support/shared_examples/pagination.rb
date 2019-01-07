# spec/support/shared_examples/pagination.rb
shared_examples 'paginated list' do
  it 'Have a meta pagination tag' do
    expect(json_response).to have_key(:meta)
    expect(json_response[:meta]).to have_key(:pagination)
    expect(json_response[:meta][:pagination]).to have_key(:'per-page')
    expect(json_response[:meta][:pagination]).to have_key(:'total-pages')
    expect(json_response[:meta][:pagination]).to have_key(:'total-objects')
  end
end
