using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Sockets;

namespace TicketAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TicketsController : ControllerBase
    {
        // datos de ejemplo
        private static List<Ticket> _tickets = new List<Ticket>
        {
            new Ticket { Id = 1, Usuario = "usuario1", FechaCreacion = DateTime.Now, FechaActualizacion = DateTime.Now, Estatus = "abierto" },
            new Ticket { Id = 2, Usuario = "usuario2", FechaCreacion = DateTime.Now, FechaActualizacion = DateTime.Now, Estatus = "cerrado" }
        };

        // GET api/tickets
        [HttpGet]
        public ActionResult<IEnumerable<Ticket>> Get() => _tickets;

        // GET api/tickets/5
        [HttpGet("{id}")]
        public ActionResult<Ticket> Get(int id)
        {
            var ticket = _tickets.FirstOrDefault(t => t.Id == id);
            if (ticket == null)
            {
                return NotFound();
            }
            return ticket;
        }

        // POST api/tickets
        [HttpPost]
        public ActionResult<Ticket> Post([FromBody] Ticket ticket)
        {
            var existingTicket = _tickets.FirstOrDefault(t => t.Id == ticket.Id);
            if (existingTicket != null)
            {
                return Conflict("El ticket ya existe.");
            }

            ticket.FechaCreacion = DateTime.Now;
            ticket.FechaActualizacion = DateTime.Now;
            _tickets.Add(ticket);
            return CreatedAtAction(nameof(Get), new { id = ticket.Id }, ticket);
        }

        // PUT api/tickets/1
        [HttpPut("{id}")]
        public ActionResult Put(int id, [FromBody] Ticket ticket)
        {
            var existingTicket = _tickets.FirstOrDefault(t => t.Id == id);
            if (existingTicket == null)
            {
                return NotFound();
            }
            existingTicket.Usuario = ticket.Usuario;
            existingTicket.FechaActualizacion = DateTime.Now;
            existingTicket.Estatus = ticket.Estatus;
            return NoContent();
        }

        // DELETE api/tickets/1
        [HttpDelete("{id}")]
        public ActionResult Delete(int id)
        {
            var existingTicket = _tickets.FirstOrDefault(t => t.Id == id);
            if (existingTicket == null)
            {
                return NotFound();
            }
            _tickets.Remove(existingTicket);
            return NoContent();
        }
    }
}
