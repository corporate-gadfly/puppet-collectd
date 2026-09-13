# frozen_string_literal: true

# Fact: python_dir
#
# Purpose: Retrieve python package dir used by pip install
#
Facter.add(:python_dir) do
  setcode do
    if Facter::Core::Execution.which('python')
      if Facter.value(:osfamily) == 'RedHat'
        Facter::Core::Execution.execute('python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"')
      else
        Facter::Core::Execution.execute('python -c "import site; print(site.getsitepackages()[0])"')
      end
    elsif Facter::Core::Execution.which('python3')
      if Facter.value(:osfamily) == 'RedHat'
        Facter::Core::Execution.execute('python3 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"')
      else
        Facter::Core::Execution.execute('python3 -c "import site; print(site.getsitepackages()[0])"')
      end
    elsif File.exist?('/usr/libexec/platform-python')
      Facter::Core::Execution.execute('/usr/libexec/platform-python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"')
    else
      ''
    end
  end
end
