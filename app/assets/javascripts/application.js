// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require popper
//= require bootstrap-sprockets
//= require_tree .

$(document).on('turbolinks:load', function() {
    // initialize search
    $('#search').hideseek({
        // attribute: 'text',
        // ignore: '.search-ignore',
        // highlight: true
        headers: '.list_header'
    });

    $('a[data-toggle="popover"]').on('click', function(e) {
        e.preventDefault();
    })

    // $('a[data-toggle="popover"]').popover();

    $('a[data-toggle="popover"]').popover({
        trigger: 'focus'
    });

    // reload twitter button
    //twttr.widgets.load();

    // toggle icons
    // $('#navbar-navigation').on('hidden.bs.collapse', function () {
    //     $('button[data-target="#navbar-navigation"] i').removeClass('fa-caret-down').addClass('fa-caret-right');
    // });
    // $('#navbar-navigation').on('show.bs.collapse', function () {
    //     $('button[data-target="#navbar-navigation"] i').removeClass('fa-caret-right').addClass('fa-caret-down');
    // });
    // $('#navbar-footer').on('hidden.bs.collapse', function () {
    //     $('button[data-target="#navbar-footer"] i').removeClass('fa-caret-down').addClass('fa-caret-right');
    // });
    // $('#navbar-footer').on('show.bs.collapse', function () {
    //     $('button[data-target="#navbar-footer"] i').removeClass('fa-caret-right').addClass('fa-caret-down');
    // });
    $('#mobile-navigation').on('show.bs.modal', function () {
        $('button#modal-mobile-navigation i').removeClass('fa-bars').addClass('fa-times');
    });
    $('#mobile-navigation').on('hidden.bs.modal', function () {
        $('button#modal-mobile-navigation i').removeClass('fa-times').addClass('fa-bars');
    });

    // define dark mode colors
    // if ($('html').hasClass('dark') === true) {
    //     var particles_color = "#6C757D";
    //     var particles_line_linked_color = "#6C757D";
    // } else {
    //     var particles_color = "#E7DFDD";
    //     var particles_line_linked_color = "#E7DFDD";
    // }

    /* particle.js */
    // particlesJS("particles-js", {
    //     particles: {
    //         number: { value: 40, density: { enable: true, value_area: 800 } },
    //         color: { value: particles_color },
    //         shape: {
    //             type: "edge",
    //             stroke: { width: 0, color: "#000000" },
    //             polygon: { nb_sides: 5 },
    //             image: { src: "img/github.svg", width: 100, height: 100 }
    //         },
    //         opacity: {
    //             value: 1,
    //             random: false,
    //             anim: { enable: false, speed: 1, opacity_min: 1, sync: false }
    //         },
    //         size: {
    //             value: 2,
    //             random: true,
    //             anim: { enable: false, speed: 40, size_min: 0.1, sync: false }
    //         },
    //         line_linked: {
    //             enable: true,
    //             distance: 150,
    //             color: particles_line_linked_color,
    //             opacity: 1,
    //             width: 1
    //         },
    //         move: {
    //             enable: true,
    //             speed: 1,
    //             direction: "none",
    //             random: false,
    //             straight: false,
    //             out_mode: "out",
    //             bounce: false,
    //             attract: { enable: false, rotateX: 600, rotateY: 1200 }
    //         }
    //     },
    //     interactivity: {
    //         detect_on: "window",
    //         events: {
    //             onhover: { enable: true, mode: "grab" },
    //             onclick: { enable: false, mode: "push" },
    //             resize: true
    //         },
    //         modes: {
    //             grab: { distance: 200, line_linked: { opacity: 1 } },
    //             bubble: { distance: 400, size: 20, duration: 2, opacity: 1, speed: 3 },
    //             repulse: { distance: 200, duration: 0.4 },
    //             push: { particles_nb: 4 },
    //             remove: { particles_nb: 2 }
    //         }
    //     },
    //     retina_detect: true
    // });
});
