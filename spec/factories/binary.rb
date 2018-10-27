include ActionDispatch::TestProcess

FactoryBot.define do
  factory :binary do
    version { '0.1.0' }
    user

    file do
      path = Rails.root.join('spec', 'fixtures', 'binaries', 'hello_world')
      fixture_file_upload(path, 'application/octet-stream')
    end
  end
end
