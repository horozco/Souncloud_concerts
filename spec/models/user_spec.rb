require "spec_helper"

describe User do
  it { should have_many (:events)}
  it { should have_many (:follows)}
  it { should have_many (:followers)}
end


