// Generated by CoffeeScript 1.6.2
(function() {
  window.requestAnimFrame = (function(){
      return  window.requestAnimationFrame       || 
              window.webkitRequestAnimationFrame || 
              window.mozRequestAnimationFrame    || 
              window.oRequestAnimationFrame      || 
              window.msRequestAnimationFrame     || 
              function(/* function */ callback, /* DOMElement */ element){
                window.setTimeout(callback, 1000 / 60);
              };
    })();
;
  var _this = this;

  window.pan = {
    init: function() {
      this.fire = this.$('fire-boiling');
      this.cover = this.$('cover-boiling');
      this.water = this.$('water-boiling');
      this.text = this.$('text');
      this.waterHeight = parseInt(this.water.getAttribute('height'), 10) + .75;
      this.waterY = parseInt(this.water.getAttribute('y'), 10);
      this.waterPercent = this.waterHeight / 100;
      this.fireVariables();
      return this.animationLoop(null, this);
    },
    fireVariables: function() {
      var stepCount, vector;

      this.top = 30.808;
      this.bottom = 27.988;
      vector = this.top - this.bottom;
      stepCount = 6;
      this.step = vector / stepCount;
      this.currTop = this.bottom;
      this.currBottom = this.top;
      this.direction1 = false;
      return this.direction2 = false;
    },
    $: function(id) {
      return document.getElementById(id);
    },
    setProgress: function(n) {
      var amount;

      if (n < 0 || n > 100) {
        return;
      }
      amount = this.waterPercent * n;
      this.water.setAttribute('height', this.waterHeight - amount);
      this.water.setAttribute('y', this.waterY + amount);
      return this.text.innerHTML = "" + n + "%";
    },
    getRand: function(min, max) {
      return Math.floor((Math.random() * ((max + 1) - min)) + min);
    },
    animateCover: function() {
      return this.cover.setAttribute('transform', "rotate(" + (this.getRand(-4, 6)) + ",16,2)");
    },
    animateFire: function() {
      if (!this.direction1) {
        if (this.currTop <= this.top) {
          this.currTop += this.step;
        } else {
          this.direction1 = true;
        }
      } else {
        if (this.currTop >= this.bottom) {
          this.currTop -= this.step;
        } else {
          this.direction1 = false;
        }
      }
      if (!this.direction2) {
        if (this.currBottom >= this.bottom) {
          this.currBottom -= this.step;
        } else {
          this.direction2 = true;
        }
      } else {
        if (this.currBottom <= this.top) {
          this.currBottom += this.step;
        } else {
          this.direction2 = false;
        }
      }
      return this.fire.setAttribute('points', "23," + (this.top - 1) + " \n21.804," + this.currTop + "\n18.985," + this.currBottom + "\n16.134," + this.currTop + "\n13.284," + this.currBottom + "\n10.404," + this.currTop + "\n9," + (this.top - 1) + "\n");
    },
    animate: function() {
      this.animateFire();
      return this.animateCover();
    },
    animationLoop: function(time) {
      this.animate();
      return requestAnimFrame(this.animationLoop.bind(this));
    }
  };

  pan.init();

  setTimeout(function() {
    var i;

    i = 0;
    return setInterval(function() {
      return pan.setProgress(++i);
    }, 100);
  }, 3000);

}).call(this);
