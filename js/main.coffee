`window.requestAnimFrame = (function(){
      return  window.requestAnimationFrame       || 
              window.webkitRequestAnimationFrame || 
              window.mozRequestAnimationFrame    || 
              window.oRequestAnimationFrame      || 
              window.msRequestAnimationFrame     || 
              function(/* function */ callback, /* DOMElement */ element){
                window.setTimeout(callback, 1000 / 60);
              };
    })();
`



# path = document.querySelector('.smoke path');
# length = path.getTotalLength();
# path.style.transition = path.style.WebkitTransition = 'none';
# path.style.strokeDasharray = length/4 + ' ' + length/4;
# path.style.strokeDashoffset = length/4;
# path.getBoundingClientRect();
# path.style.transition = path.style.WebkitTransition = 'stroke-dashoffset 1s ease-in-out';
# path.style.strokeDashoffset = '0';



window.boiling = 
	init:->
		@fire 	= @$ 'fire-boiling'
		@cover 	= @$ 'cover-boiling'
		@water 	= @$ 'water-boiling'
		@text 	= @$ 'text'

		@waterHeight = parseInt(@water.getAttribute('height'), 10) + .75
		@waterY 		 = parseInt(@water.getAttribute('y'), 10)
		@waterPercent = @waterHeight/100

		@fireVariables()

		@animationLoop null, @


	fireVariables:->
		@top 		= 30.808
		@bottom 	= 27.988

		vector = @top - @bottom

		stepCount 	= 6
		@step 			= vector/stepCount

		@currTop 		= @bottom
		@currBottom = @top
		@direction1 = false
		@direction2 = false

	$:(id)-> document.getElementById id

	setProgress:(n)->
		if n < 0 or n > 100 then return
		amount = @waterPercent*n
		@water.setAttribute 'height', @waterHeight - amount
		@water.setAttribute 'y', @waterY + amount
		@text.innerHTML = "#{n}%"

	getRand:(min,max)->
		Math.floor((Math.random() * ((max + 1) - min)) + min)

	animateCover:->
		@cover.setAttribute 'transform', "rotate(#{@getRand(-4,6)},16,2)"

	animateFire:->
		if !@direction1
			if @currTop <= @top
				@currTop += @step
			else @direction1 = true
		else
			if @currTop >= @bottom
				@currTop -= @step
			else @direction1 = false

		if !@direction2
			if @currBottom >= @bottom
				@currBottom -= @step
			else @direction2 = true
		else 
			if @currBottom <= @top
				@currBottom += @step
			else @direction2 = false


		@fire.setAttribute 'points', """
												
												23,#{@top-1} 
												21.804,#{@currTop}
												18.985,#{@currBottom}
												16.134,#{@currTop}
												13.284,#{@currBottom}
												10.404,#{@currTop}
												9,#{@top-1}

												"""


	animate:->
		@animateFire()
		@animateCover()

	animationLoop:(time)->
		@animate()
		requestAnimFrame(@animationLoop.bind(@))

boiling.init()

setTimeout =>
	i=0
	setInterval =>
		boiling.setProgress ++i

	, 100

, 3000




