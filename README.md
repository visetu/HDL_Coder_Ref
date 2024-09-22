# HDL_Coder_Ref
Reference to HDL Coder Designs

https://www.speedgoat.com/learn-support/hdl-coder-workflow

https://github.com/mathworks/HDL-Coder-Evaluation-Reference-Guide

https://imperix.com/doc/help/matlab-hdl-coder
https://imperix.com/doc/category/software
https://imperix.com/doc/category/implementation
https://imperix.com/doc/help/fpga-development-on-imperix-controllers


Article REVIEW:

I. INTRODUCTION:

Common startup methods include:

DC bias currents to align the rotor initially (so called a magnetic rotor alignment).

Initial position estimation based on magnetic saliency (sensorless control) or Position Encoder.

Open-loop acceleration using V/f control (beware that it can become unstable, especially under load).

Field-Oriented Control (FOC), which provides better control of d-axis and q-axis currents.

The transition from open-loop startup to closed-loop control (sensorless or based on encoder).

The I-f startup method for control of PMSMs has the following features:

It overcomes high current/torque ripples issues with open-loop V/f startup during transition to FOC. 

It specifies and maintains constant current in a synchronous rotating reference frame (RRF), rather than specifying voltage like V/f control.

The motor is accelerated by ramping up the frequency command.

A critical aspect is designing a smooth transition period to switch to either Sensorless or Encoder-Sensor FOC.

The method is robust to different load conditions and motor parameter variations.

II. CONTROL SYSTEM FOR PMSM

The control system topology for a PMSM consists of two main parts:

Current regulation control for startup

Traditional FOC using position either from an Encoder or estimated from back-EMF.

Key points:

The system can switch between startup mode and normal FOC mode using two switches.

In normal FOC mode, it uses:

Inner current control loops with PI controllers.

Outer speed control loop.

Rotating d-,q- reference frame (RRF).

The control algorithm for rotor position and speed estimation is based on either:

An Absolute Position Encoder.

The Absolute Position Encoder method works well at any speeds.

A simple back-EMF based sensorless :

Uses stator α-,β- reference frame model of PMSM.

Assumes equal d-axis and q-axis inductances.

Calculates estimated position and speed using voltage and current measurements.

The back-EMF method works well at medium to high speeds.

Practical implementation requires compensation for integration drift.

At higher speeds, the method is less sensitive to stator resistance variations and inverter nonlinearity.

Equations are provided for:

PMSM model in α-,β- frame

Flux linkage calculations

Estimated rotor position and speed.

This topology allows for sensorless/encoder control of the PMSM, with a dedicated startup procedure before transitioning to normal FOC operation using estimated position/speed.

Proper selection of acceleration rate and q-axis current decrease rate is crucial to avoid losing synchronization during startup.

The startup procedure uses switches to change the control mode from startup to normal FOC operation.

III. ANALYSIS OF THE STARTUP STRATEGY

The startup procedure has two stages:
A) Ramp speed reference with constant q-axis current (torque), i.e. the motor is accelerated from standstill to a desired speed.
B) Constant speed reference with decreasing q-axis current (torque).

The first phase of an I-f startup method . 
Control approach:

Uses a synchronous rotating reference frame (d*q*) obtained either by integrating a ramp speed command (sensorless) or from Position Encoder.

Maintains constant q*-axis current and zero d*-axis current

Startup procedure:

Align rotor to zero position using DC currents (MTPA.omega=0, MTPA.torque=CONST).

Set d*q* frame lagging real rotor dq frame by 90 electrical degrees

Apply constant q*-axis current

Integrate ramp speed command to rotate d*q* frame.

Self-stabilization mechanism:

As load increases, angle θL between d*q* and dq frames decreases.

This increases real q-axis current, producing more torque to maintain speed

Stability considerations:

dq frame must always lag real rotor frame (θL > 0)

Sufficient q*-axis current needed to maintain stability margin

Speed ramp design:

Ramp rate Kω must be chosen carefully based on motor parameters, inertia, and load

Upper limit given by equation (15) to ensure stability

Key equations:

Torque equation (7)

Speed ramp equation (8)

Mechanical equation (9)

Angle dynamics equation (10)

Speed ramp limit equation (15)

The goal is to accelerate the motor in a controlled manner while maintaining stability, before transitioning to sensorless control at higher speeds.

 

Open {0A49F197-D1BC-43DE-9E69-582732DBF412}-20240921-210419.png

Second phase of the I-f startup method 
Purpose: Provide a smooth transition from open-loop acceleration to closed-loop field-oriented control (FOC).

Rationale:

Prevents current and torque ripple due to mismatched current amplitudes

Allows machine parameters to stabilize

Compensates for potential inaccuracies in position estimation

Reduces mismatch between open-loop and FOC current amplitudes

Minimizes current and torque ripple during transition

Allows d-axis current to reduce to zero

Approach:

Maintain constant speed

Gradually decrease q*-axis current

Implementation:

Keep speed constant after reaching desired value

Decrease q*-axis current linearly

Monitor angle θL between virtual and real q-axis

Switch to FOC when θL reaches a small threshold (e.g., 5°)

Benefits:

Reduces mismatch between open-loop and FOC current amplitudes

Minimizes current and torque ripple during transition

Allows d-axis current to reduce to zero

Key parameter: Current reduction ratio Ki

Determines how quickly q*-axis current decreases

Affects the rate of θL reduction

Optimal Ki ensures smooth transition to FOC current

Design considerations:

Ki should be large enough for quick transition

Ki should be small enough to avoid undershoot of FOC current

Equation (20) provides guidance for selecting Ki

Transition dynamics:

θL decreases as q*-axis current reduces

Rotor speed remains constant during transition

Load torque is assumed constant

Simulation results:

Validate the analytical equations and design approach

Demonstrate successful transition with minimal current ripple

This phase ensures a smooth transition from open-loop startup to closed-loop sensorless control by gradually aligning the virtual reference frame with the actual rotor position.

The current reduction ratio Ki during the transition phase from open-loop acceleration to closed-loop field-oriented control (FOC). Key points include:

Equation (20) relates Ki to the initial angle θL(t0), initial q-axis current i*q0, and the angle reduction rate Kθ.

Increasing Ki results in faster reduction of angle θL(t).

The optimal Ki should reduce θL(t) to the threshold value (e.g., 5°) while bringing the q-axis current close to the FOC operating point (2A in this example).

A range of Ki values (0.5 to 2) achieve good performance, minimizing current and torque ripple during transition.

Too large Ki (e.g., 5 or 15) causes undershoot of the q-axis current, leading to increased ripple during transition.

Equation (20) can be used to estimate an appropriate Ki, with the constraint Ki < 3.9 for this specific case.

The startup strategy is summarized in four stages:

Stage 1: Rotor position initialization

Stage 2: Speed ramp-up with constant current

Stage 3: Constant speed with decreasing current

Stage 4: Switching to FOC mode

This analysis helps in designing a smooth transition from open-loop startup to closed-loop sensorless control by properly selecting the current reduction rate. 

IV. TEST PLATFORM AND EXPERIMENTAL RESULTS
This section describes the experimental setup and results for testing the proposed startup strategy for sensorless control of a permanent magnet synchronous motor (PMSM). Key points include:

Experimental setup:

SPMSM motor

DC motor as load

eZdsp-F28335 controller

Danfoss FC302 Series inverter

2048-pulse incremental encoder for validation

CCS3.3 platform

Test conditions:

Switching from startup to FOC at 20 Hz/600 rpm (20% of rated speed)

Tests performed with DC motor load and no load

Results with DC motor load:

Successful acceleration to desired speed

Smooth transition to sensorless FOC at 4.3s

Low current and torque ripple during transition

Results with no load:

Successful acceleration to desired speed

Transition to sensorless FOC at 6.0s

Smaller rise time and larger speed ripple due to higher net torque

Angle estimation:

θL (angle between virtual and real q-axis) and θ'L (angle between virtual and estimated q-axis) plotted

θ'L used to trigger transition to FOC

Position estimation inaccurate at low speeds and before current reduction phase

Current reduction phase:

Improves position estimation accuracy

Reduces d-axis current component

Allows smooth transition to sensorless FOC

Observations:

Inaccurate machine parameters affect position estimation

Current reduction phase aligns virtual frame with real rotor position

No-load case shows higher oscillations, which can be reduced by adjusting speed ramp rate

The experimental results validate the effectiveness of the proposed startup strategy in achieving smooth transition to sensorless FOC operation.

V. Conclusion summarizes the key advantages 
Current control: The stator current is under control throughout the startup process.

Self-stabilization: The strategy has a self-stabilizing mechanism even without speed feedback.

Load adaptability: It can work under different load conditions.

Dynamic stability: Proper setting of reference current and speed ramp-up ratio ensures stability based on load and system parameters.

Smooth transition: A new transition process is introduced before switching to sensorless FOC, ensuring:

Accurate position estimation from back-EMF

Automatic adjustment of q-axis current to match FOC values

Elimination of d-axis current component

Minimal ripple: The smooth transition results in very small current and torque ripple when switching to sensorless FOC.

Design guidance: Detailed analysis and design guidelines are provided for implementing the startup strategy.

Validation: The proposed method is validated through both simulation and experimental results.

Overall, this startup strategy offers a robust and smooth method for starting PMSMs in sensorless control applications, addressing key challenges in the transition from startup to closed-loop field-oriented control.
