import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BOARD)
control_pins = [7,11,13,15]

for pin in control_pins:
  GPIO.setup(pin, GPIO.OUT)
  GPIO.output(pin, 0)

StepCount = 8
halfstep_seq = [
  [1,0,0,0],
  [1,1,0,0],
  [0,1,0,0],
  [0,1,1,0],
  [0,0,1,0],
  [0,0,1,1],
  [0,0,0,1],
  [1,0,0,1]
]

def forward(freq, time):
    for i in range(time/freq):
        for j in range(StepCount):
            for pin in range(4):
                GPIO.output(control_pins[pin], halfstep_seq[j][pin])
            time.sleep(1/(StepCount*freq))
    GPIO.cleanup()
print("Hello World, Trial process") 
def backwards(freq, time):
    for i in range(time/freq):
        for j in reversed(range(StepCount)):
            for pin in range(4):
                GPIO.output(control_pins[pin], halfstep_seq[j][pin])
            time.sleep(1/(StepCount*freq))
    GPIO.cleanup()