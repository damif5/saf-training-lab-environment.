control "SV-250315" do
  title "RHEL 8 systems, versions 8.2 and above, must configure SELinux context type to allow the use of 
a non-default faillock tally directory."
  desc "By limiting the number of failed logon attempts, the risk of unauthorized system access via 
user password guessing, otherwise known as brute-force attacks, is reduced. Limits are 
imposed by locking the account.

From \"faillock.conf\" man pages: Note that the default 
directory that \"pam_faillock\" uses is usually cleared on system boot so the access will be 
re-enabled after system reboot. If that is undesirable, a different tally directory must be 
set with the \"dir\" option.

SELinux, enforcing a targeted policy, will require any 
non-default tally directory's security context type to match the default directory's 
security context type. Without updating the security context type, the pam_faillock module 
will not write failed login attempts to the non-default tally directory."
  desc "check", "If the system does not have SELinux enabled and enforcing a targeted policy, or if the 
pam_faillock module is not configured for use, this requirement is not applicable.

Note: 
This check applies to RHEL versions 8.2 or newer. If the system is RHEL version 8.0 or 8.1, this 
check is not applicable.

Verify the location of the non-default tally directory for the 
pam_faillock module with the following command:

$ sudo grep -w dir 
/etc/security/faillock.conf

dir = /var/log/faillock

Check the security context type 
of the non-default tally directory with the following command:

$ sudo ls -Zd 
/var/log/faillock

unconfined_u:object_r:faillog_t:s0 /var/log/faillock

If the 
security context type of the non-default tally directory is not \"faillog_t\", this is a 
finding."
  desc "fix", "Configure RHEL 8 to allow the use of a non-default faillock tally directory while SELinux 
enforces a targeted policy.

Create a non-default faillock tally directory (if it does not 
already exist) with the following example:

$ sudo mkdir /var/log/faillock

Update the 
/etc/selinux/targeted/contexts/files/file_contexts.local with \"faillog_t\" context 
type for the non-default faillock tally directory with the following command:

$ sudo 
semanage fcontext -a -t faillog_t \"/var/log/faillock(/.*)?\" 

Next, update the context 
type of the non-default faillock directory/subdirectories and files with the following 
command:	

$ sudo restorecon -R -v /var/log/faillock"
  impact 0.5
  tag severity: "medium"
  tag gtitle: "SRG-OS-000021-GPOS-00005"
  tag gid: "V-250315"
  tag rid: "SV-250315r793009_rule"
  tag stig_id: "RHEL-08-020027"
  tag fix_id: "F-53703r793001_fix"
  tag cci: ["CCI-000044","CCI-002238"]
  tag nist: ["AC-7 a","AC-7 b"]
end