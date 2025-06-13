import json
import random
from loguru import logger
from spade.behaviour import OneShotBehaviour
from spade.template import Template
from spade.message import Message
from pygomas.bditroop import BDITroop
from agentspeak import Actions
from agentspeak import grounded
from agentspeak.stdlib import actions as asp_action
from pygomas.ontology import DESTINATION
from pygomas.agent import LONG_RECEIVE_WAIT

class BDIGeneral(BDITroop):
    def add_custom_actions(self, actions):
        super().add_custom_actions(actions)

        @actions.add(".comunicar_generales", 0)
        def comunicar_generales(agent, term, intention):
            """Los generales se comunican antes de dar la orden."""
            if self.name in ["general_allied_1", "general_allied_2"]:
                self.bdi.set_belief("general_listo", True)
                logger.info(f"{self.name} ha comunicado con el otro general.")
            yield

        @actions.add(".dar_orden", 0)
        def dar_orden(agent, term, intention):
            """Solo los generales pueden dar la orden después de comunicarse."""
            if self.name in ["general_allied_1", "general_allied_2"]:
                if self.bdi.has_belief("general_listo"):
                    self.bdi.set_belief("comunicacion_generales", True)
                    logger.info(f"{self.name} ha dado la orden de avanzar.")
            yield
