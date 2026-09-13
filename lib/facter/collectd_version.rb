# frozen_string_literal: true

# Fact: collectd_version
#
# Purpose: Retrieve collectd version if installed
#
# Resolution:
#
# Caveats:  not well tested
#
Facter.add(:collectd_version) do
  setcode do
    if Facter::Core::Execution.which('collectd')
      collectd_help = Facter::Core::Execution.execute('collectd -h')
      %r{^collectd ([+\w.]+), http://collectd\.org/}.match(collectd_help)[1]
    end
  end
end
