
require 'spec_helper'

describe 'roundcube' do

  let :facts do
    {
      :operatingsystemrelease => 'test',
      :osfamily               => 'Debian',
      :operatingsystem        => 'Debian',
      :lsbdistcodename        => 'Debian',
    }
  end

  let :default_params do
      { :ensure_database => false,
        :ensure_vhost    => false,
      }
  end

  shared_examples 'roundcube shared examples' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class('roundcube::install') }
    it { is_expected.to contain_class('roundcube::config') }
  end

  context 'with defaults' do
    let :params do
      default_params
    end
    it_behaves_like 'roundcube shared examples'

    it { is_expected.to_not contain_class('roundcube::db') }
    it { is_expected.to_not contain_class('roundcube::vhost') }
  end

  context 'with db' do
    let :params do
      default_params.merge( :ensure_database => true )
    end
    it_behaves_like 'roundcube shared examples'

    it { is_expected.to contain_class('roundcube::db') }
    it { is_expected.to_not contain_class('roundcube::vhost') }
  end

# context 'with vhost' do
#   let :params do
#     default_params.merge( :ensure_vhost => true )
#   end
#   it_behaves_like 'roundcube shared examples'

#   it { is_expected.to_not contain_class('roundcube::db') }
#   it { is_expected.to contain_class('roundcube::vhost') }
# end

end

