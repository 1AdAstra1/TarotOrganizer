require "spec_helper"

describe InterpretationsController do
  describe "routing" do

    it "routes to #index" do
      get("/interpretations").should route_to("interpretations#index")
    end

    it "routes to #new" do
      get("/interpretations/new").should route_to("interpretations#new")
    end

    it "routes to #show" do
      get("/interpretations/1").should route_to("interpretations#show", :id => "1")
    end

    it "routes to #edit" do
      get("/interpretations/1/edit").should route_to("interpretations#edit", :id => "1")
    end

    it "routes to #create" do
      post("/interpretations").should route_to("interpretations#create")
    end

    it "routes to #update" do
      put("/interpretations/1").should route_to("interpretations#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/interpretations/1").should route_to("interpretations#destroy", :id => "1")
    end

  end
end
