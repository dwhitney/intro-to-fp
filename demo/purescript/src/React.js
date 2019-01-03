"use strict";

const React = require('react');

exports.createElement = function(name){
  return function(props){
    return function(children){
      return React.createElement(name, props, children);
    };
  };
};

exports.fragment = function(children) {
  return React.createElement.apply(null, [React.Fragment, {}].concat(children));
};

exports.empty = null;
