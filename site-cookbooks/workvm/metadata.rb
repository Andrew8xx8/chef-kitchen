maintainer       "Andrew Kulakov"
maintainer_email "avk@8xx8.ru"
license          "MIT License"
description      "General waytag machine"
version          "0.1"

%w{ apt }.each do |cb_depend|
  depends cb_depend
end
%w{ debian ubuntu }.each do |os|
  supports os
end
