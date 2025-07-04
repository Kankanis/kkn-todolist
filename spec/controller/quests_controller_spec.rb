require 'rails_helper'

RSpec.describe QuestsController, type: :controller do
  let(:valid_attributes) {
    { name: "Test Quest", status: false }
  }

  let(:invalid_attributes) {
    { name: nil, status: nil }
  }

  describe "GET #index" do
    before do
        Quest.destroy_all
    end

    it "returns a successful response" do
      Quest.create! valid_attributes
      get :index
      expect(response).to be_successful
    end

    it "assigns all quests as @quests" do
      quest = Quest.create! valid_attributes
      get :index
      expect(assigns(:quests)).to eq([ quest ])
    end
  end

  describe "GET #show" do
    it "returns a successful response" do
      quest = Quest.create! valid_attributes
      get :show, params: { id: quest.to_param }
      expect(response).to be_successful
    end

    it "assigns the requested quest as @quest" do
      quest = Quest.create! valid_attributes
      get :show, params: { id: quest.to_param }
      expect(assigns(:quest)).to eq(quest)
    end
  end

  describe "GET #new" do
    it "returns a successful response" do
      get :new
      expect(response).to be_successful
    end

    it "assigns a new quest as @quest" do
      get :new
      expect(assigns(:quest)).to be_a_new(Quest)
    end
  end

  describe "GET #edit" do
    it "returns a successful response" do
      quest = Quest.create! valid_attributes
      get :edit, params: { id: quest.to_param }
      expect(response).to be_successful
    end

    it "assigns the requested quest as @quest" do
      quest = Quest.create! valid_attributes
      get :edit, params: { id: quest.to_param }
      expect(assigns(:quest)).to eq(quest)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Quest" do
        expect {
          post :create, params: { quest: valid_attributes }
        }.to change(Quest, :count).by(1)
      end

      it "assigns a newly created quest as @quest" do
        post :create, params: { quest: valid_attributes }
        expect(assigns(:quest)).to be_a(Quest)
        expect(assigns(:quest)).to be_persisted
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: "Updated Quest", status: true }
      }

      it "updates the requested quest" do
        quest = Quest.create! valid_attributes
        put :update, params: { id: quest.to_param, quest: new_attributes }
        quest.reload
        expect(quest.name).to eq("Updated Quest")
        expect(quest.status).to eq(true)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested quest" do
      quest = Quest.create! valid_attributes
      expect {
        delete :destroy, params: { id: quest.to_param }
      }.to change(Quest, :count).by(-1)
    end

    it "redirects to the quests list" do
      quest = Quest.create! valid_attributes
      delete :destroy, params: { id: quest.to_param }
      expect(response).to redirect_to(quests_url)
    end
  end
end
