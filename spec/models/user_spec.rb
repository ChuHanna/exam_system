require "rails_helper"

RSpec.describe User, type: :model do
  context "association" do
    it {should have_many(:users_workspaces)}
    it {should have_many(:workspaces).through(:users_workspaces)}
    it {should have_many(:messages)}
  end

  context "validations" do
    it "should validate email address" do
      should validate_presence_of :email
      should validate_length_of(:email).is_at_most(Settings.email.max_length)
    end

    it "email is valid" do
      should allow_value("email@address.domain").for(:email)
    end

    it "email is invalid" do
      should_not allow_value("email").for(:email)
      should_not allow_value("email.domain").for(:email)
      should_not allow_value("em ail.domain").for(:email)
      should_not allow_value("emai#l.domain").for(:email)
    end

    it "name is valid" do
      should allow_value("").for(:fullname)
      should allow_value("hien nguyen").for(:name)
    end

    it "name is too long, less than 255 characters" do
      str_255 = "A2qfa4X$w{nXbybtAqkT4&p9zq9zgjA=Yg?d3DH+EE?MSPc9B%?y3/GGQey*=mG8zt}=={p{WyC-1PxXB/kmt\3f$RzX*n%Yx3zBqwd7BHdF3=xbBW*JDe{BdXGr1e-Rm3tJ%EMg_B4rt*c=jKHS+nFE5knFb-5mW9j0Bae{6ETfxN$S_Bg9-Dg2wCN0JgmME2{hN{Gx_c*T!=k44cFs*9Y5MtxDSq6j*FNtRE3!!$HMTA7$fG!xP!b4g?JjC2QddC"
      should_not allow_value(str_255).for(:fullname)
    end
  end

  context "enum" do
    it "should define enum for status" do
      should define_enum_for(:status).with_values inactive: 0, active: 1, pending: 2
    end

    it "should define enum for role" do
      should define_enum_for(:role).with_values trainee: 0, trainer: 1, admin: 2
  end
end
