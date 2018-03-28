
# UI

#!/bin/bash
echo "Password:"
read password
echo "Cobudget root folder:"
COBUDGET_ROOT_FOLDER="~"
echo $password | sudo -S apt-get update
echo $password | sudo -S apt-get install -y git
echo $password | sudo -S apt install -y npm
echo $password | sudo -S apt-get install -y nodejs

# Set proxy if needed
#npm config set proxy http://...
#npm config set https-proxy http://...

git clone https://github.com/cobudget/cobudget-ui
cd cobudget-ui
#echo $password | sudo -S apt-get install rpl
npm install minimatch
npm install graceful-fs
echo $password | sudo -S npm install -g node-gyp
npm install pug
npm install serve-favicon
npm install uuid
npm install cross-spawn
#rpl "^4.5.6" ">=5.0.0" $COBUDGET_ROOT_FOLDER/cobudget-ui/package.json
npm install ampersand-state --save-prod
#rpl "^4.5.6" ">=5.0.0" $COBUDGET_ROOT_FOLDER/cobudget-ui/package.json
npm install ampersand-state
npm install angular
npm install angular-animate
npm install angular-aria
npm install angular-autoselect
npm install angular-cookie
npm install angular-eha.only-digits
npm install angular-eha.only-digits --save-prod
npm install angular-marked
#rpl "^0.10.1" ">=1.0.0" $COBUDGET_ROOT_FOLDER/cobudget-ui/package.json
#rpl ">=1.0.00" ">=1.0.0" $COBUDGET_ROOT_FOLDER/cobudget-ui/package.json
npm install angular-material
npm install angular-material-icons
npm install angular-messages
npm install angular-sanitize
npm install angular-truncate-2
npm install angular-ui-router
git config --global url."https://".insteadOf git://
npm install angular-upload
npm install angular_record_store
npm install angular-mocks
npm install babel --save-dev
npm install --save-dev babel
npm install --save-dev babelify
npm install --save-dev brfs
npm install --save-dev browserify
npm install --save-dev browserify-ngannotate
npm install camelize
npm install --save-dev chai
npm install --save-dev chai-as-promised
npm install --save-dev coffee-script
npm install --save-dev coffeeify
npm install --save-dev concatenify
npm install --save-dev connect-livereload
npm install debug
npm install --save-dev ecstatic
npm install --save-dev envify
npm install es5-shim
npm install --save-dev evalify
npm install --save-dev express
npm install gulp
npm install --save-dev gulp
npm install --save-dev gulp-autoprefixer
npm install gulp-build-branch
npm install --save-dev gulp-filter
npm install --save-dev gulp-livereload
npm install --save-dev gulp-nodemon
npm install --save-dev gulp-plumber
npm install --save-dev gulp-rename
echo $password | sudo -S ln -s /usr/bin/nodejs /usr/bin/node
npm install --save-dev gulp-sass
npm install --save-dev gulp-sourcemaps
npm install --save-dev gulp-util
npm install --save-dev gulp-watch
npm install is-empty-object
npm install jquery
npm install json3
npm install listify
npm install lodash
npm install lokijs
npm install --save-dev mocha
npm install moment
npm install morph
npm install napa
npm install --save-dev napa
npm install ng-focus-if
npm install ng-q-all-settled
npm install ng-sanitize
npm install ng-token-auth
npm install node-sass
npm install --save-dev protractor
npm install recase
npm install --save-dev sinon
npm install --save-dev sinon-chai
npm install --save-dev testling
npm install --save-dev tiny-lr
npm install --save-dev txtify
npm install --save-dev txtify2
npm install --save-dev uglifyify
npm install --save-dev vinyl-buffer
npm install --save-dev vinyl-source-stream
npm install --save-dev watchify
npm install xtend
echo $password | sudo -S npm install -g bower
npm install timeout
timeout 60s npm install angular-autodisable
npm install angular-autodisable
npm install
$password=""
npm run develop 
