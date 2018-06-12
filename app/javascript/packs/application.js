/* eslint no-console:0 */

import '../src/application.css'
import '../src/upload.css'

import Rails from 'rails-ujs';
Rails.start();

import Turbolinks from 'turbolinks';
Turbolinks.start();

import * as ActiveStorage from 'activestorage';
import '../src/upload.js';
ActiveStorage.start();

import '../src/log.js';
import '../src/ajax.js';
