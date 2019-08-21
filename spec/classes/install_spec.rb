require 'spec_helper'

describe 'roundcube::install' do
  let :default_params do
    {  packages: ['roundcube'],
       package_ensure: 'present' }
  end

  shared_examples 'roundcube::install shared examples' do
    it { is_expected.to compile.with_all_deps }

    it {
      is_expected.to contain_package('roundcube')
        .with_name('roundcube')
        .with_ensure(params[:package_ensure])
    }
  end

  context 'with defaults' do
    let :params do
      default_params
    end

    it_behaves_like 'roundcube::install shared examples'
  end

  context 'with non defaults' do
    let :params do
      default_params.merge(
        packages: ['somepackage', 'roundcube'],
        package_ensure: 'absent',
      )
    end

    it_behaves_like 'roundcube::install shared examples'

    it {
      is_expected.to contain_package('somepackage')
        .with_name('somepackage')
        .with_ensure(params[:package_ensure])
    }
  end
end
