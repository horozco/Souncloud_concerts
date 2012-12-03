require "spec_helper"

describe Event do
  it { should belong_to (:user) }
  it { should have_attached_file(:event_image) }
  it { should validate_attachment_content_type(:event_image).
                allowing('image/png', 'image/jpeg', 'image/jpg')}
  it { should validate_attachment_size(:event_image).
                less_than(5.megabytes) }
end