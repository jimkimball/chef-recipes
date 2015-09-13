$emacs_local_file = 'c:\temp\emacs-24.5-bin-i686-mingw32.zip'
remote_file $emacs_local_file do
  source 'ftp://ftp.gnu.org/gnu/emacs/windows/emacs-24.5-bin-i686-mingw32.zip'
  action :create_if_missing
end

directory 'c:\emacs' do
  :create
end
  

powershell_script 'extract zip' do
  code '''
$zipfile=Get-Item("c:\temp\emacs-24.5-bin-i686-mingw32.zip")
$shell=new-object -com shell.application
$Location=$shell.namespace("c:\emacs")
$ZipFolder = $shell.namespace($zipfile.fullname)
$Location.Copyhere($ZipFolder.items())
'''
  guard_interpreter :powershell_script
  not_if { File.exists?('c:\emacs\bin\runemacs.exe') }
end




