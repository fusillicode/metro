// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
require('bootstrap-loader');

// import loadView from './views/loadView';

// function handleDOMContentLoaded() {
//   const viewName = document.getElementsByTagName('body')[0].dataset.jsViewPath;

//   const view = loadView(viewName);
//   view.mount();

//   window.currentView = view;
// }

// function handleDocumentUnload() {
//   window.currentView.unmount();
// }

// window.addEventListener('DOMContentLoaded', handleDOMContentLoaded, false);
// window.addEventListener('unload', handleDocumentUnload, false);


import React, { Component } from 'react'
import ReactDOM from 'react-dom'

import FineUploaderTraditional from 'fine-uploader-wrappers'
import Gallery from 'react-fine-uploader'

// ...or load this specific CSS file using a <link> tag in your document
import 'react-fine-uploader/gallery/gallery.css'

const uploader = new FineUploaderTraditional({
    options: {
        chunking: {
            enabled: true
        },
        deleteFile: {
            enabled: true,
            endpoint: '/admin/media'
        },
        request: {
            endpoint: '/admin/media'
        },
        retry: {
            enableAuto: true
        }
    }
})

class UploadComponent extends Component {
    render() {
        return (
            <Gallery uploader={ uploader } />
        )
    }
}

ReactDOM.render(<UploadComponent/>, document.getElementById('gallery'));
