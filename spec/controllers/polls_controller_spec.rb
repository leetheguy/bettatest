require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe PollsController do

  # This should return the minimal set of attributes required to create a valid
  # Poll. As you add validations to Poll, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {}
  end

  describe "GET index" do
    it "assigns all polls as @polls" do
      poll = Poll.create! valid_attributes
      get :index
      assigns(:polls).should eq([poll])
    end
  end

  describe "GET show" do
    it "assigns the requested poll as @poll" do
      poll = Poll.create! valid_attributes
      get :show, :id => poll.id
      assigns(:poll).should eq(poll)
    end
  end

  describe "GET new" do
    it "assigns a new poll as @poll" do
      get :new
      assigns(:poll).should be_a_new(Poll)
    end
  end

  describe "GET edit" do
    it "assigns the requested poll as @poll" do
      poll = Poll.create! valid_attributes
      get :edit, :id => poll.id
      assigns(:poll).should eq(poll)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Poll" do
        expect {
          post :create, :poll => valid_attributes
        }.to change(Poll, :count).by(1)
      end

      it "assigns a newly created poll as @poll" do
        post :create, :poll => valid_attributes
        assigns(:poll).should be_a(Poll)
        assigns(:poll).should be_persisted
      end

      it "redirects to the created poll" do
        post :create, :poll => valid_attributes
        response.should redirect_to(Poll.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved poll as @poll" do
        # Trigger the behavior that occurs when invalid params are submitted
        Poll.any_instance.stub(:save).and_return(false)
        post :create, :poll => {}
        assigns(:poll).should be_a_new(Poll)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Poll.any_instance.stub(:save).and_return(false)
        post :create, :poll => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested poll" do
        poll = Poll.create! valid_attributes
        # Assuming there are no other polls in the database, this
        # specifies that the Poll created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Poll.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => poll.id, :poll => {'these' => 'params'}
      end

      it "assigns the requested poll as @poll" do
        poll = Poll.create! valid_attributes
        put :update, :id => poll.id, :poll => valid_attributes
        assigns(:poll).should eq(poll)
      end

      it "redirects to the poll" do
        poll = Poll.create! valid_attributes
        put :update, :id => poll.id, :poll => valid_attributes
        response.should redirect_to(poll)
      end
    end

    describe "with invalid params" do
      it "assigns the poll as @poll" do
        poll = Poll.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Poll.any_instance.stub(:save).and_return(false)
        put :update, :id => poll.id, :poll => {}
        assigns(:poll).should eq(poll)
      end

      it "re-renders the 'edit' template" do
        poll = Poll.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Poll.any_instance.stub(:save).and_return(false)
        put :update, :id => poll.id, :poll => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested poll" do
      poll = Poll.create! valid_attributes
      expect {
        delete :destroy, :id => poll.id
      }.to change(Poll, :count).by(-1)
    end

    it "redirects to the polls list" do
      poll = Poll.create! valid_attributes
      delete :destroy, :id => poll.id
      response.should redirect_to(polls_url)
    end
  end

end
