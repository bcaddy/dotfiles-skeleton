/*!
 * \brief Contains the InputParser class for parsing command line input
 *
 */

#pragma once

// STL includes
#include <string>
#include <algorithm>
#include <vector>
#include <stdexcept>

/*!
 * \brief Class for parsing input flags. Modified from
 * https://stackoverflow.com/questions/865668/parsing-command-line-arguments-in-c
 *
 * \details Usage: To directly get the argument associated with a specific class
 * call `InputParser.getCmdOption("flagString")`, note that this will throw and
 * error if the flag doesn't exists. You can use
 * InputParser.cmdOptionExists("flagString")` to just check if a specific flag
 * exists.
 */
class InputParser{
    public:
        // =====================================================================
        /*!
         * \brief Get the option that follows the given flag. Also checks that
         * the flag exists and is not empty
         *
         * \param option The string option to look for
         * \return const std::string& The option the follows a given flag
         */
        const std::string& getCmdOption(const std::string &option) const
        {
            // First check that the option exists
            if(not cmdOptionExists(option))
            {
                std::string errMessage = "Error: argument '" + option + "' not found. ";
                throw std::invalid_argument(errMessage);
            }

            std::vector<std::string>::const_iterator itr;
            itr =  std::find(this->tokens.begin(), this->tokens.end(), option);
            if (itr != this->tokens.end() && ++itr != this->tokens.end())
            {
                return *itr;
            }
            else
            {
                std::string errMessage = "Error: empty argument '" + option + "'";
                throw std::invalid_argument(errMessage);
            }
        }
        // =====================================================================

        // =====================================================================
        /*!
         * \brief Checks that an option exists. Returns True if it exists and
         * False otherwise
         *
         * \param option The option flag to search for
         * \return true The option flag exists in argv
         * \return false The option flage does not exist in argv
         */
        bool cmdOptionExists(const std::string &option) const
        {
            return std::find(this->tokens.begin(), this->tokens.end(), option)
            != this->tokens.end();
        }
        // =====================================================================

        // =====================================================================
        // constructor and destructor
        /*!
         * \brief Construct a new Input Parser object
         *
         * \param argc argc from main
         * \param argv argv from main
         */
        InputParser (int &argc, char **argv)
        {
            for (int i=1; i < argc; ++i)
            this->tokens.push_back(std::string(argv[i]));
        }
        ~InputParser() = default;
        // =====================================================================
    private:
        std::vector <std::string> tokens;
};