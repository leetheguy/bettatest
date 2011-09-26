require 'spec_helper'
describe LeadersController do
#  def valid_attributes
#    {}
#  end
#
#  describe "GET index" do
#    it "assigns all leaders as @leaders" do
#      leader = Leader.create! valid_attributes
#      get :index
#      assigns(:leaders).should eq([leader])
#    end
#  end
#
#  describe "GET show" do
#    it "assigns the requested leader as @leader" do
#      leader = Leader.create! valid_attributes
#      get :show, :id => leader.id.to_s
#      assigns(:leader).should eq(leader)
#    end
#  end
#
#  describe "GET new" do
#    it "assigns a new leader as @leader" do
#      get :new
#      assigns(:leader).should be_a_new(Leader)
#    end
#  end
#
#  describe "GET edit" do
#    it "assigns the requested leader as @leader" do
#      leader = Leader.create! valid_attributes
#      get :edit, :id => leader.id.to_s
#      assigns(:leader).should eq(leader)
#    end
#  end
#
#  describe "POST create" do
#    describe "with valid params" do
#      it "creates a new Leader" do
#        expect {
#          post :create, :leader => valid_attributes
#        }.to change(Leader, :count).by(1)
#      end
#
#      it "assigns a newly created leader as @leader" do
#        post :create, :leader => valid_attributes
#        assigns(:leader).should be_a(Leader)
#        assigns(:leader).should be_persisted
#      end
#
#      it "redirects to the created leader" do
#        post :create, :leader => valid_attributes
#        response.should redirect_to(Leader.last)
#      end
#    end
#
#    describe "with invalid params" do
#      it "assigns a newly created but unsaved leader as @leader" do
#        # Trigger the behavior that occurs when invalid params are submitted
#        Leader.any_instance.stub(:save).and_return(false)
#        post :create, :leader => {}
#        assigns(:leader).should be_a_new(Leader)
#      end
#
#      it "re-renders the 'new' template" do
#        # Trigger the behavior that occurs when invalid params are submitted
#        Leader.any_instance.stub(:save).and_return(false)
#        post :create, :leader => {}
#        response.should render_template("new")
#      end
#    end
#  end
#
#  describe "PUT update" do
#    describe "with valid params" do
#      it "updates the requested leader" do
#        leader = Leader.create! valid_attributes
#        # Assuming there are no other leaders in the database, this
#        # specifies that the Leader created on the previous line
#        # receives the :update_attributes message with whatever params are
#        # submitted in the request.
#        Leader.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
#        put :update, :id => leader.id, :leader => {'these' => 'params'}
#      end
#
#      it "assigns the requested leader as @leader" do
#        leader = Leader.create! valid_attributes
#        put :update, :id => leader.id, :leader => valid_attributes
#        assigns(:leader).should eq(leader)
#      end
#
#      it "redirects to the leader" do
#        leader = Leader.create! valid_attributes
#        put :update, :id => leader.id, :leader => valid_attributes
#        response.should redirect_to(leader)
#      end
#    end
#
#    describe "with invalid params" do
#      it "assigns the leader as @leader" do
#        leader = Leader.create! valid_attributes
#        # Trigger the behavior that occurs when invalid params are submitted
#        Leader.any_instance.stub(:save).and_return(false)
#        put :update, :id => leader.id.to_s, :leader => {}
#        assigns(:leader).should eq(leader)
#      end
#
#      it "re-renders the 'edit' template" do
#        leader = Leader.create! valid_attributes
#        # Trigger the behavior that occurs when invalid params are submitted
#        Leader.any_instance.stub(:save).and_return(false)
#        put :update, :id => leader.id.to_s, :leader => {}
#        response.should render_template("edit")
#      end
#    end
#  end
#
#  describe "DELETE destroy" do
#    it "destroys the requested leader" do
#      leader = Leader.create! valid_attributes
#      expect {
#        delete :destroy, :id => leader.id.to_s
#      }.to change(Leader, :count).by(-1)
#    end
#
#    it "redirects to the leaders list" do
#      leader = Leader.create! valid_attributes
#      delete :destroy, :id => leader.id.to_s
#      response.should redirect_to(leaders_url)
#    end
#  end
#
end
