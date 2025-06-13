//TEAM_ALLIED

+flag (F): team(100) 
  <-
  +target([200,0,10]);
  .goto([200,0,10]). 

+target_reached(T): team(100) 
  <- 
  -target([200,0,10]);
  .wait(5000);  // Esperan 5 segundos en el objetivo
  ?comunicacion_generales;  // Esperan la comunicación entre los generales
  .print("Orden recibida, avanzando en formación...");
  .mover_en_formacion.

+flag_taken: team(100) 
  <-
  .print("In ASL, TEAM_ALLIED flag_taken");
  ?base(B);
  +returning;
  .goto(B);
  -exploring.

+heading(H): exploring
  <-
  .reload;
  .wait(2000);
  .turn(0.375).

// Comunicación entre generales
+!comunicar_generales <- .print("General esperando comunicación...");
                         ?general_listo;
                         .set_belief(comunicacion_generales, true).

// El general da la orden cuando la comunicación ha ocurrido
+!dar_orden <- .print("Soy el general, dando la orden...");
                .set_belief(general_listo, true).

// Acción de moverse en formación
+!mover_en_formacion <- .print("Moviéndome en formación hacia la bandera.");
                         .move_to(flag_position).

+enemies_in_fov(ID,Type,Angle,Distance,Health,Position)
  <-
  .shoot(3,Position).
