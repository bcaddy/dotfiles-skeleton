/*!
 * \file PersistentCommunicator.h
 * \author Robert 'Bob' Caddy (rvc@pitt.edu)
 * \brief Contains the declartion and implementation of the
 * PersistentCommunicator class which is used for easily managing MPI persistent
 * communication
 *
 */

#pragma once

// STL Includes
#include <exception>

// External Includes
#include <mpi.h>

// Local Includes

// =============================================================================
// Declaration of PersistentCommunicator class
// =============================================================================
/*!
 * \brief A class for performing persistent MPI communication.
 *
 */
class PersistentCommunicator
{
public:
    /*!
     * \brief Construct a new Persistent Communicator object
     *
     * \param[in] commKind What kind of communication to perform. Options are
     * "send" and "receive". Anything else will throw a std::invalid_argument
     * error
     * \param[in] bufferPointer The pointer to the begining of the memory
     * segment to send
     * \param[in] numElements The number of elements to communicate
     * \param[in] mpi_type The MPI_Dataatype of the communication
     * \param[in] otherRank The rank of the other MPI processing being
     * communicated with. In the case of a send this is the recipient rank and
     * in the case of a receive this is the senders rank
     * \param[in] tag Tag for the communication, defaults to zero.
     * \param[in] mpiCommunicator The MPI communicator to use. Defaults to
     * `MPI_COMM_WORLD`
     */
    PersistentCommunicator(std::string  const &commKind,
                           void               *bufferPointer,
                           int          const &numElements,
                           MPI_Datatype const mpi_type,
                           int          const &otherRank,
                           int          const &tag = 0,
                           MPI_Comm     const &mpiCommunicator = MPI_COMM_WORLD);

    /*!
     * \brief Destroy the Persistent Communicator object
     *
     */
    ~PersistentCommunicator(){MPI_Request_free(&_request);};

    /*!
     * \brief Start the MPI communication
     *
     * \return int The return value of the MPI_Start command
     */
    int start(){return MPI_Start(&_request);}

    /*!
     * \brief Wait on the MPI communication to finish
     *
     * \return int The return value of the MPI_Wait command
     */
    int wait() {return MPI_Wait(&_request, &status);}

    /*!
     * \brief Test if the communication is complete
     *
     * \param[out] flag The flag that MPI_Test returns
     * \return int The return value of MPI_Test
     */
    int test(int &flag) {return MPI_Test(&_request, &flag, &status);}

    /*!
     * \brief Get the MPI_Request object
     *
     * \return MPI_Request The MPI request that this class uses
     */
    MPI_Request getRequest(){return _request;}

    /// The status of the last command that returns a MPI_Status struct
    MPI_Status status;

    /// The communication kind. Either "send" or "receive"
    std::string  const commKind;

    /// The pointer to the start of the buffer
    void *       const bufferPointer;

    /// The number of elements being communicated
    int          const numElements;

    /// The MPI_Datatype being communicated. Note that this is a hex value
    MPI_Datatype const mpi_type;

    /// The other rank being communicated with
    int          const otherRank;

    /// The tag of this communication
    int          const tag;

    /// The MPI communicator that this communication uses. Note that this is a
    /// hex value
    MPI_Comm     const mpiCommunicator;

private:
    /// The MPI request for the persistent communication
    MPI_Request _request;
};
// =============================================================================
// End declaration of PersistentCommunicator class
// =============================================================================

// =============================================================================
// Implementation of PersistentCommunicator class
// =============================================================================

// =============================================================================
// Public Methods
// =============================================================================

// =============================================================================
PersistentCommunicator::PersistentCommunicator(std::string  const &commKind,
                                               void               *bufferPointer,
                                               int          const &numElements,
                                               MPI_Datatype const mpi_type,
                                               int          const &otherRank,
                                               int          const &tag,
                                               MPI_Comm     const &mpiCommunicator)
    :
    commKind(commKind),
    bufferPointer(bufferPointer),
    numElements(numElements),
    mpi_type(mpi_type),
    otherRank(otherRank),
    tag(tag),
    mpiCommunicator(mpiCommunicator)
{
    int status;
    if (commKind == "send")
    {
        status = MPI_Send_init(bufferPointer,
                               numElements,
                               mpi_type,
                               otherRank,
                               tag,
                               mpiCommunicator,
                               &_request);
    }
    else if (commKind == "receive")
    {
        status = MPI_Recv_init(bufferPointer,
                               numElements,
                               mpi_type,
                               otherRank,
                               tag,
                               mpiCommunicator,
                               &_request);
    }
    else
    {
        throw std::invalid_argument("Invalid commKind passed to "
                                    "PersistentCommunicator. Expected \"send\" "
                                    "or \"receive\", got " + commKind);
    }

    // Check that the communication was initialized
    if (status != 0)
    {
        throw std::runtime_error("MPI persistent communication failed to "
                                 "initialize. Error Code: "
                                 + std::to_string(status));
    }
}
// =============================================================================

// =============================================================================
// Private Methods
// =============================================================================

// =============================================================================
// End implementation of PersistentCommunicator class
// =============================================================================