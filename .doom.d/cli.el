;;; cli.el -*- lexical-binding: t; -*-

(advice-add #'native-compile-async :override #'ignore)
