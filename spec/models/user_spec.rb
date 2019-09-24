require 'spec_helper'

describe User do
  let(:user) { Fabricate.build(:user) }
  let(:admin) { Fabricate.build(:admin) }

  context "validation" do
    it "is valid" do
      expect(user).to be_valid
    end

    it "handles timezones" do
      expect(Fabricate.build(:user, time_zone: 'bla')).to_not be_valid
      expect(Fabricate.build(:user, time_zone: 'Berlin')).to be_valid
    end
  end

  it "generates wegli_email" do
    user = Fabricate.build(:user, token: 'dd-33', nickname: 'Funktä rd--//')
    expect(user.wegli_email).to eql('funkta-rd+dd-33@anzeige.weg-li.de')
  end

  it "handles districts" do
    expect(user.district).to be(DistrictLegacy::HAMBURG)
    user.district = DistrictLegacy::LUENEBURG.name
    expect(user.district).to be(DistrictLegacy::LUENEBURG)
  end

  context "admin" do
    it "has the proper role" do
      expect(admin).to be_admin
    end
  end
end
