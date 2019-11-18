require 'rails_helper'

RSpec.describe HomesController, type: :controller do
  # 正常にレスポンスを返すこと
  it "#top responds successfully" do
    get :top
    expect(response).to be_success
  end

  # 200レスポンスを返すこと
  it "#top returns a 200 response" do
    get :top
    expect(response).to have_http_status(200)
  end

  # 正常にレスポンスを返すこと
  it "#about responds successfully" do
    get :about
    expect(response).to be_success
  end

  # 200レスポンスを返すこと
  it "#about returns a 200 response" do
    get :about
    expect(response).to have_http_status(200)
  end
end
