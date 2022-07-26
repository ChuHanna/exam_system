require("@rails/ujs").start()
//import Rails from '@rails/ujs';
//Rails.start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("jquery")
require("packs/bootstrap.bundle.min")
require("packs/jquery.easing.min")
require("packs/sb-admin-2.min")
require("packs/jquery-213.min")
require("packs/bootstrap-datepicker")
require("packs/datepicker")
require("packs/repeat_type")
require("packs/select2.min")
require("packs/count_down")
// require("packs/create_message")
import "bootstrap";
import jquery from "jquery";
import "cocoon"
import "chartkick/chart.js"

window.$ = window.jquery = jquery
global.toastr = require("toastr")
