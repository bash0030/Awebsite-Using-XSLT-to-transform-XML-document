<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="xml" indent="yes"/>

  <xsl:param name = "minRating"  ></xsl:param>
  
  <xsl:template match="/">

    <div>

      <xsl:for-each select="restaurants/restaurant">

        <xsl:sort select="Rating" order="descending" data-type="number"/>
        <xsl:choose>

          <xsl:when test="/restaurants/restaurant[Rating > $minRating]">

            <h2>
              <xsl:value-of select="name" />
            </h2>

            <ul>
              <li>
                Address <xsl:value-of select="Address/Street " />,  <xsl:value-of select="Address/street " />,  <xsl:value-of select="Address/city " />,  <xsl:value-of select="Address/province " />, <xsl:value-of select="Address/city " />,  <xsl:value-of select="Address/postalCode " />
              </li>
              <li>
                Phone (<xsl:value-of select="Phone/areaCode" />) <xsl:value-of select="Phone/number " />
              </li>

            </ul>
            <h3>Summary</h3>
            <p>
              <xsl:value-of select="Summary" />
            </p>

            <h3>
              Rating: <xsl:value-of select = "Rating" />
            </h3>

            <h3>Menu</h3>
            <table border = "1" >
              <tr>
                <th>Description</th>
                <th>Quantity</th>
                <th>Price</th>
              </tr>
              <tr>
                <th colspan="3">
                  Appetizers
                </th>
              </tr>
              <xsl:for-each select="menu/Appetizers/Appetizer">
                <xsl:sort select="description" order="ascending"/>
                <tr>
                  <td>
                    <xsl:value-of select="description" />

                  </td>

                  <td>

                    <xsl:choose>
                      <xsl:when test="price/@quantity" >

                        <xsl:value-of select="price/@quantity" />
                      </xsl:when>

                      <xsl:otherwise>
                        1
                      </xsl:otherwise>

                    </xsl:choose>

                  </td>
                  <td>
                    <xsl:value-of select="price" />
                  </td>
                </tr>
              </xsl:for-each>
              <tr>
                <th colspan="3">
                  Entrees
                </th>
              </tr>
              <xsl:for-each select="menu/Entrees/Entree">
                <xsl:sort select="description" order="ascending"/>
                <tr>
                  <td>
                    <xsl:value-of select="description" />
                  </td>
                  <td>

                    <xsl:choose>
                      <xsl:when test="price/@quantity" >

                        <xsl:value-of select="price/@quantity" />
                      </xsl:when>

                      <xsl:otherwise>
                        1
                      </xsl:otherwise>

                    </xsl:choose>
                  </td>
                  <td>
                    <xsl:value-of select="price" />

                  </td>
                </tr>
              </xsl:for-each>

            </table>
          </xsl:when>

          <xsl:otherwise>
            No restaurant having rating above  <xsl:value-of select="$minRating" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </div>
  </xsl:template>
</xsl:stylesheet>
