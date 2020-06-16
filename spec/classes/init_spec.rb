require File.expand_path(File.join(File.dirname(__FILE__),'../spec_helper'))
describe 'crypto_policy', :type => 'class' do

  # pre_condition definition
  let(:pre_condition) do
    "
    Exec{
      path => '/usr/sbin:/usr/bin:/sbin:/bin'
    }
    "
  end

  describe 'CentOS 8 standard' do
    let(:facts) {
      Octofacts.from_file('centos8.example.com.yaml')
    }

    it { should compile.with_all_deps }

    it { should contain_exec('update-crypto-policies').with(
      :command => 'update-crypto-policies --set DEFAULT',
      :unless  => 'update-crypto-policies --show | grep -q ^DEFAULT$',
    )}

    context 'with policy level future' do
      let(:params) {{
        :level => 'future',
      }}

      it { should compile.with_all_deps }

      it { should contain_exec('update-crypto-policies').with(
        :command => 'update-crypto-policies --set FUTURE',
        :unless  => 'update-crypto-policies --show | grep -q ^FUTURE$',
      )}
    end
  end
end
